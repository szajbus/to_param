module ToParam
  
  protected
  
  # Defines to_param instance method that is used internally by Rails, for example when generating URLs.
  # Additionally defines find_by_param, find_by_param!, find_all_by_param and find_all_by_param!
  # class methods.
  #
  # ==== Usage
  #   class Article < ActiveRecord::Base
  #     to_param :slug
  #   end
  #
  #   Atricle.find_by_param "rails-recipes"
  def to_param(attribute)
    define_method "to_param" do
      send(attribute)
    end
    
    meta_def "find_by_param" do |*args|
      send("find_by_#{attribute}", args.size == 1 ? args.first : args)
    end
    
    meta_def "find_by_param!" do |*args|
      send("find_by_#{attribute}!", args.size == 1 ? args.first : args)
    end
    
    meta_def "find_all_by_param" do |*args|
      send("find_all_by_#{attribute}", args.size == 1 ? args.first : args)
    end
    
    meta_def "find_all_by_param!" do |*args|
      send("find_all_by_#{attribute}!", args.size == 1 ? args.first : args)
    end
  end
  
  def meta_def name, &blk
    (class << self; self; end).instance_eval { define_method name, &blk }
  end
  
end

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:extend, ToParam)
end