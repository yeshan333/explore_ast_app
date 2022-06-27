defmodule ExploreAstApp.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias ExploreAstApp.Router

  @content "<html><body>Hi!</body></html>"
  @mimetype "text/html"

  @opts Router.init([])

  test "returns welcome" do
    conn =
      :get
      |> conn("/welcome", "")
      |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns uploaded" do
    conn =
      :get
      |> conn("/upload?content=#{@content}&mimetype=#{@mimetype}")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 201
  end

  test "upload slug miss params" do
    ExUnit.Assertions.assert_raise ExploreAstApp.Plug.VerifyRequest.IncompleteRequestError, fn ->
      conn =
        :get
        |> conn("/upload")
        |> Router.call(@opts)
      assert conn.state == :sent
      assert conn.status == 400
    end
  end

  test "return hello yeshan" do
    conn =
      :get
      |> conn("/hello/yeshan")
      |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "hello yeshan"
  end

  test "return hello Jams (query params)" do
    conn =
      :get
      |> conn("/hello?name=Jams")
      |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "hello Jams"
  end

  test "return hello Jams (post json data)" do
    request_body = %{"name" => "John"}

    conn =
      :post
      |> conn("/hello", request_body)
      |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "\{\"id\":1,\"name\":\"John\"}"
  end

  test "return (post empty data)" do
    conn =
      :post
      |> conn("/hello")
      |> Router.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"id\":1,\"name\":\"\"}"
  end

  test "returns 404" do
    conn =
      :get
      |> conn("/missing", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end
end
