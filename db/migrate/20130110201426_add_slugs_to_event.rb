# -*- encoding : utf-8 -*-
class AddSlugsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :slug, :string
    add_column :artists, :slug, :string
    add_column :posts, :slug, :string
    add_column :projects, :slug, :string
    FriendlyIdSlug.where(:sluggable_type => 'Event').each do |slug|
      e = Event.find(slug.sluggable_id) rescue next
      next if e.nil?
      e.slug = slug.slug
      e.save!
    end
    FriendlyIdSlug.where(:sluggable_type => 'Post').each do |slug|
      p = Post.find(slug.sluggable_id) rescue next
      next if p.nil?
      p.slug = slug.slug
      p.save!
    end
    FriendlyIdSlug.where(:sluggable_type => 'Project').each do |slug|
      p = Project.find(slug.sluggable_id) rescue next
      next if p.nil?      
      p.slug = slug.slug
      p.save!
    end
    FriendlyIdSlug.where(:sluggable_type => 'Artist').each do |slug|
      p = Artist.find(slug.sluggable_id) rescue next
      next if p.nil?
      p.slug = slug.slug
      p.save!
    end      
    Post.find_each(&:save)  
  end
end
