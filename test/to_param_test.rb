require 'test_helper'

class Article
  extend ToParam
  
  attr_accessor :slug
  
  def self.find_by_slug(*args)
    "find_by_slug called with #{args}"
  end
  
  def self.find_by_slug!(*args)
    "find_by_slug! called with #{args}"
  end
  
  def self.find_all_by_slug(*args)
    "find_all_by_slug called with #{args}"
  end
  
  def self.find_all_by_slug!(*args)
    "find_all_by_slug! called with #{args}"
  end
  
end

class ToParamTest < Test::Unit::TestCase
  
  def setup
    Article.send("to_param", :slug)
  end
  
  def test_to_param
    article = Article.new
    article.slug = "dummy"
    assert "dummy", article.to_param
  end
  
  def test_find_by_param
    assert Article.respond_to?("find_by_param")
    assert_equal "find_by_slug called with dummy", Article.find_by_param("dummy")
  end
  
  def test_find_by_param!
    assert Article.respond_to?("find_by_param!")
    assert_equal "find_by_slug! called with dummy", Article.find_by_param!("dummy")
  end
  
  def test_find_all_by_param
    assert Article.respond_to?("find_all_by_param")
    assert_equal "find_all_by_slug called with dummy", Article.find_all_by_param("dummy")
  end
  
  def test_find_all_by_param!
    assert Article.respond_to?("find_all_by_param!")
    assert_equal "find_all_by_slug! called with dummy", Article.find_all_by_param!("dummy")
  end
end
