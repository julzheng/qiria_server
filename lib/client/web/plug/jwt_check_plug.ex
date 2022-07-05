defmodule Client.Web.JWTCheck do
  import Plug.Conn
  alias Kaur.Result

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> extract_token
    |> Result.and_then(&verify_jwt/1)
    |> case do
      {:ok, _reason} -> conn
      {:error, reason} ->
        unauthorize(conn, reason)
    end
  end

  defp extract_token(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization") do
      {:ok, token}
    else
      _ -> {:error, "No authorization token found."}
    end
  end

  defp verify_jwt(token) do
    with {:ok, asymmetric_crypto} <-
           Vaultex.Client.read(
             "qiria/asymmetric_crypto",
             :token,
             {Application.get_env(:vaultex, :vault_token)}
           ) do
      jwk_ec256_priv = JOSE.JWK.from_map(asymmetric_crypto["priv"])

      content =
        JOSE.JWE.block_decrypt(jwk_ec256_priv, token)
        |> elem(0)
        |> String.replace("'", "\"")
        |> Jason.decode!()

      case is_jwt_content_satisfactory?(content) do
        true -> {:ok, :verification_succeed}
        false -> {:error, :verification_failed}
      end
    else
      {:error, _} -> {:error, :verification_failed}
    end
  end

  defp unauthorize(conn, _msg) do
    send_resp(conn, :unauthorized, "") |> halt()
  end

  defp is_jwt_content_satisfactory?(content) do
    with "Amalistback" <- content["aud"],
         "Amalist" <- content["iss"] do
      true
    else
      false -> false
    end
  end
end
