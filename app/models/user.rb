class User < ApplicationRecord
    EMAILS = ["tanluiscarlos32@gmail.com"].freeze

    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
          user.email = auth.info.email
        end
    end
end
