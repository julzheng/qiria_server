defmodule Library.Utils.PEM do
  def to_pem(public, private) do
    public_pem =
      entity_from_keys(public, private, :SubjectPublicKeyInfo)
      |> der_encode_entity
      |> pem_encode_der

    private_pem =
      entity_from_keys(public, private, :ECPrivateKey)
      |> der_encode_entity
      |> pem_encode_der

    {public_pem, private_pem}
  end

  def strip_to_pem_content(pem) do
    pem_header = "-----BEGIN PUBLIC KEY-----"
    pem_footer = "-----END PUBLIC KEY-----"

    pem_content =
      String.replace(pem, ~r/(\r\n|\n|\r)/, "")
      |> String.replace(pem_header, "")
      |> String.replace(pem_footer, "")

    pem_content
  end

  defp entity_from_keys(public, private, format) do
    case format do
      :ECPrivateKey ->
        {:ECPrivateKey, 1, private, {:namedCurve, {1, 3, 132, 0, 10}}, public, :asn1_NOVALUE}

      :SubjectPublicKeyInfo ->
        {:SubjectPublicKeyInfo,
         {:AlgorithmIdentifier, {1, 2, 840, 10045, 2, 1},
          <<6, 8, 42, 134, 72, 206, 61, 3, 1, 7>>}, public}
    end
  end

  defp der_encode_entity(ec_entity),
    do:
      {elem(ec_entity, 0),
       :public_key.der_encode(
         elem(ec_entity, 0),
         ec_entity
       )}

  defp pem_encode_der({type, der_encoded}),
    do: :public_key.pem_encode([{type, der_encoded, :not_encrypted}])
end
