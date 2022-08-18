defmodule Client.Web.KeyController do
  use Client.Web, :controller

  def show(conn, _params) do
    with {:ok, asymmetric_keys} <-
           Vaultex.Client.read(
             "qiria/asymmetric_crypto",
             :token,
             {Application.get_env(:vaultex, :vault_token)}
           ),
         true <- Map.has_key?(asymmetric_keys, "ttl"),
         false <- is_expired?(asymmetric_keys) do
      pub_key_map = asymmetric_keys["pub"]

      {_, pem} = JOSE.JWK.to_pem(pub_key_map)

      conn
      |> put_view(Client.Web.JSONView)
      |> render("show.json",
        assigns: %{
          meta: %{message: nil},
          data: %{science: pem |> Library.Utils.PEM.strip_to_pem_content()}
        }
      )
    else
      _ ->
        jwk_ec256_sk = JOSE.JWK.generate_key({:ec, :secp256r1})
        {_, pub_key_map} = JOSE.JWK.to_public_map(jwk_ec256_sk)
        {_, priv_key_map} = JOSE.JWK.to_map(jwk_ec256_sk)

        {_, pem} = JOSE.JWK.to_pem(pub_key_map)

        Vaultex.Client.write(
          "qiria/asymmetric_crypto",
          %{
            priv: priv_key_map,
            pub: pub_key_map,
            ttl: "30m",
            inserted_at: DateTime.utc_now()
          },
          :token,
          {Application.get_env(:vaultex, :vault_token)}
        )

        conn
        |> put_view(Client.Web.JSONView)
        |> render("show.json",
          assigns: %{
            meta: %{message: nil},
            data: %{science: pem |> Library.Utils.PEM.strip_to_pem_content()}
          }
        )
    end
  end

  defp is_expired?(asymmetric_keys) do
    if String.at(asymmetric_keys["ttl"], -1) == "m" do
      {minutes, _} = Integer.parse(String.slice(asymmetric_keys["ttl"], 0..-2))

      {:ok, inserted_at, 0} = DateTime.from_iso8601(asymmetric_keys["inserted_at"])

      inserted_at
      |> DateTime.add(minutes * 60)
      |> DateTime.compare(DateTime.utc_now())
      |> (&(&1 == :lt)).()
    end
  end
end
