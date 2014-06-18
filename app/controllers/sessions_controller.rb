class SessionsController < ApplicationController

  def donors_login
  end

  def donors_create
    if donor = Donor.find_by_email(params[:email])
      if donor.authenticate(params[:password])
        session[:donor_id] = donor.id
        # need campaign info from session
        redirect_to campaign_path(session[:campaign])
      else
        flash.now.alert = 'Invalid Password'
        render 'donors_login'
      end
    else
      flash.now.alert = 'Invalid Email'
      render 'donors_login'
    end
  end

  def organizations_login
    # is this check the best place for this?
    if session[:organization_id]
      redirect_to organization_path(Organization.find(session[:organization_id]))
    end
  end

  def organizations_create
    if organization = Organization.find_by_email(params[:email])
      if organization.authenticate(params[:password])
        session[:organization_id] = organization.id
        redirect_to organization_path(organization)
      else
        flash.now.alert = 'Invalid Password'
        render 'organizations_login'
      end
    else
      flash.now.alert = 'Invalid Organization Email'
      render 'organizations_login'
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end

end