# -*- encoding : utf-8 -*-
RECAPTCHA_PUBLIC_KEY  = '6LdlLsQSAAAAAM8YsJLAAlHZRThgXNKf91cRsmOM'
RECAPTCHA_PRIVATE_KEY = '6LdlLsQSAAAAAOK050cBHtYQj2gd3_Frvs_5-FqC'
Recaptcha.configure do |config|
    config.public_key  = RECAPTCHA_PUBLIC_KEY    
    config.private_key = RECAPTCHA_PRIVATE_KEY
end
