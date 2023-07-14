require "pagy/extras/bootstrap"

# Pagy::I18n.load({locale: "en"},
#                 {locale: "vi",
#                  filepath: Rails.root.join("config/locales/pagy-vi.yml")})

# # When you are done setting your own default freeze it, so it will not get changed accidentally
# Pagy::DEFAULT.freeze
# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:items] = 10        # items per page
Pagy::DEFAULT[:size]  = [1,4,4,1] # nav bar links
# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page