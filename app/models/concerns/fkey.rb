module Fkey
  extend ActiveSupport::Concern

  included do
    has_one :user, :as => :fkey
  end
end