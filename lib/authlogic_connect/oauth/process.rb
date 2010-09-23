module AuthlogicConnect::Oauth::Process
  # Step 2: after save is called, it runs this method for validation
  def validate_by_oauth
    if processing_authentication
      #prevent saving user when starting oauth
      if begin_oauth = authentication_protocol(:oauth, :start)
        errors.add_to_base('please dont save user object')
      end
      begin_oauth || authentication_protocol(:oauth, :complete)
    end
  end
end