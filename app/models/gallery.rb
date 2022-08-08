class Gallery < ApplicationRecord
    has_many :pictures, dependent: :destroy
    has_many :picture_comments, through: :pictures
end
