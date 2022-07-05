defmodule Client.Web.Router do
  use Client.Web, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Client.Web.APIAuthPlug, otp_app: :qiria)
  end

  pipeline :external do
    plug(:accepts, ["json"])
    plug(Client.Web.JWTCheck)
  end

  pipeline :api_protected do
    plug(Pow.Plug.RequireAuthenticated, error_handler: Client.Web.APIAuthErrorHandler)
  end

  scope "/api", Client.Web do
    pipe_through(:api)
    resources("/session", SessionController, singleton: true, only: [:create, :delete])
    post("/session/renew", SessionController, :renew)
  end

  scope "/api", Client.Web do
    get("/key", KeyController, :show)

    pipe_through([:api, :external])
    post("/check_email", UserController, :check)
    post("/registration", RegistrationController, :create)
    post("/login", LoginController, :create)
  end

  scope "/api", Client.Web do
    pipe_through([:api, :api_protected])
    get("/health", HealthController, :show)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: Client.Web.Telemetry)
    end
  end
end
