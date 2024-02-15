# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, if: proc{ !current_admin_user.present? }, label: proc { I18n.t("active_admin.dashboard") }

  controller do
    skip_before_action :authenticate_active_admin_user, only: :index
  end

  action_item :login, if: proc{ !current_admin_user.present? }, only: :index do
    link_to "Log In", new_admin_user_session_path
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        div do
          image_tag("albert.png")
        end
        span "Welcome to Albert's Customer Relationship Manager"
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
