ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Active Schools" do
          ul do
            School.active(5).map do |school|
              li link_to(school.name, admin_school_path(school))
            end
          end
        end
      end

      column do
        panel "Active Shared Badges" do
          ul do
            Badge.tagged_with("s:shared").active(5).map do |badge|
              li link_to(badge.name, admin_badge_path(badge))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
