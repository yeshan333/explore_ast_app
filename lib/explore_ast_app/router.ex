defmodule ExploreAstApp.Router do
  use Plug.Router
  use Plug.ErrorHandler

  import Plug.Conn

  alias ExploreAstApp.Plug.VerifyRequest

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug VerifyRequest, fields: ["content", "mimetype"], paths: ["/upload"]
  plug :match
  plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason
  plug :dispatch

  get "/welcome" do
    send_resp(conn, 200, "Welcome")
  end

  get "/upload" do
    send_resp(conn, 201, "Uploaded")
  end

  get "/hello" do
    # query parameter is user like this:
    # http://localhost:4001/hello?name=John
    # which will create %{"name" => "John"}
      send_resp(conn, 200, "hello #{Map.get(conn.query_params, "name")}")
  end

  get "/hello/:name" do
    send_resp(conn, 200, "hello #{name}")
  end

  post "/hello" do
    # json body of POST request {"name": "John"} is parsed to %{"name" => "John"}
    # so it can be accesable with e.g. Map.get(conn.body_params, "name") or with pattern matching
    name =
      case conn.body_params do
        %{"name" => a_name } -> a_name
        _ -> ""
      end

    # returning JSON: {"id":1, "name": name}
    response = %{"id" => 1, "name" => name}
    send_resp(conn |> put_resp_content_type("application/json"), 200, Jason.encode!(response))
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
