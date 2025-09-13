defmodule UpwardWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: UpwardWeb
      import Plug.Conn
      import UpwardWeb.Gettext
      alias UpwardWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/upward_web/templates",
        namespace: UpwardWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      import Phoenix.LiveView.Helpers
      import UpwardWeb.ErrorHelpers
      import UpwardWeb.Gettext
      alias UpwardWeb.Router.Helpers, as: Routes
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {UpwardWeb.LayoutView, "live.html"}
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import UpwardWeb.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
