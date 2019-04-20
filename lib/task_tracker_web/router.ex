defmodule TaskTrackerWeb.Router do
  use TaskTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TaskTrackerWeb.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskTrackerWeb do
    pipe_through :browser # Use the default browser stack
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    resources "/users", UserController
    resources "/tasks", TaskController


    get "/", PageController, :index
  end
end
