class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # we need to do something along the lines of
    # User.find_by(uid) in order to link up the facebook user with a user in our database

    p "*" * 100
    ap request.env
    p "*" * 100

    if @user.persisted?
      # p @user
      # p "$" * 100
      # p params
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      # p "&" * 100
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

# request.env params 
# "omniauth.auth" => {
#            "provider" => "facebook",
#                 "uid" => "1594470537260516",
#                "info" => {
#              "name" => "Joe Moorhouse",
#             "image" => "http://graph.facebook.com/v2.6/1594470537260516/picture"
#         },
#         "credentials" => {
#                  "token" => "EAAaNQZBZA3VEUBAG8YikW4FBFB0TtFZBSnv0SRqj6M9ZAxlb7HCPWN5h5f9Df8iOlLpDWYFlsrNc3Ms91lGuE2XWwIMunJPBHBl75LAVWqZBjY9mT8uiEVt58GHuMpiEXqMJwNbUC3gVjFp3yjosRddTinzc5OcIZD",
#             "expires_at" => 1496539481,
#                "expires" => true
#         },
#               "extra" => {
#             "raw_info" => {
#                 "name" => "Joe Moorhouse",
#                   "id" => "1594470537260516"
#             }
#         }
#     },
#             "action_dispatch.request.path_parameters" => {
#         :controller => "users/omniauth_callbacks",
#             :action => "facebook"
#     },
