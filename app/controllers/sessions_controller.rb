class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = 'DQJXCMESVRB515RR32YKKHJZELN40EYVFHFFJCV23MSAKRN4'
      req.params['client_secret'] = 'LHPGHVAVIXZAXYCYYO3RNXD15JF2S4GRPTAB1DULUIGWVTKP'
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
