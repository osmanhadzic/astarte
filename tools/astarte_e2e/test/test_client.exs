
defmodule AstarteE2E.TestClient do
  use ExUnit.Case
  alias AstarteE2E.Client
  alias AstarteE2E.Config

  @valid_opts [
    url: "wss://example.com/socket",
    jwt: "valid_jwt_token",
    realm: "test_realm",
    device_id: "test_device_id",
    check_repetitions: 1
  ]

  describe "start_link/1" do
    test "starts the client process with valid options" do

      assert {:ok, pid} = Client.start_link(@valid_opts)
      assert is_pid(pid)
    end

    test "fails to start the client process with missing options" do
      invalid_opts = Keyword.delete(@valid_opts, :url)
      assert_raise KeyError, fn -> Client.start_link(invalid_opts) end
    end

    test "fails to start the client process with invalid options" do
      invalid_opts = Keyword.put(@valid_opts, :url, nil)
      assert_raise KeyError, fn -> Client.start_link(invalid_opts) end
    end
  end

  describe "verify_device_payload/6" do
    test "verifies device payload successfully" do
      Client.start_link(@valid_opts)
      assert :ok = Client.verify_device_payload("test_realm", "test_device_id", "interface", "path", "value", 123456)
    end

    test "returns error when client is not connected" do
      assert {:error, :not_connected} = Client.verify_device_payload("test_realm", "test_device_id", "interface", "path", "value", 123456)
    end
  end

  describe "wait_for_connection/2" do
    test "waits for connection successfully" do
      Client.start_link(@valid_opts)
      assert :ok = Client.wait_for_connection("test_realm", "test_device_id")
    end

    test "returns error when client is not connected" do
      assert {:error, :not_connected} = Client.wait_for_connection("test_realm", "test_device_id")
    end
  end
end
