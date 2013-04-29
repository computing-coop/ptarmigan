# -*- encoding : utf-8 -*-
class Wikipage < ActiveRecord::Base
  has_many :wikirevisions
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }

  def icon
    'wiki_page.png'
  end

  def name
    title
  end
end
