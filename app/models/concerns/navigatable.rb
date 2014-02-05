module Navigatable

  extend ActiveSupport::Concern

  included do
    has_permalink(:title, true)

    acts_as_taggable
    ActsAsTaggableOn.remove_unused_tags = true
    ActsAsTaggableOn.force_lowercase = true
    ActsAsTaggableOn.force_parameterize = true

    scope :latest, ->(num=1){
      where(published: true).order(created_at: :desc).limit(num)
    }

    scope :filter_by, ->(filter=nil, published=true){
      case filter
        when /year/
          created = 1.year.ago
        when /month/
          created = 1.month.ago
        when /day/
          created = DateTime.now.beginning_of_day
        else
          created = 5.years.ago
      end
      if published
        where("#{self.table_name}.created_at > ? and #{self.table_name}.published = ?", created, published).order(created_at: :desc)
      else
        where("#{self.table_name}.created_at > ?", created).order(created_at: :desc)
      end
    }

  end

  def to_param
    permalink
  end

  def first(published=true)
    published ? self.class.where("published = ?", published).order("id ASC").first : self.class.first
  end

  def next(published=true)
    published ? self.class.where("id > ? and published = ?", id, published).order("id ASC").first : self.class.where("id > ?", id).order("id ASC").first
  end

  def prev(published=true)
    published ? self.class.where("id < ? and published = ?", id, published).order("id DESC").first : self.class.where("id < ?", id).order("id DESC").first
  end

  def last(published=true)
    published ? self.class.where("published = ?", published).order("id ASC").last : self.class.last
  end


end