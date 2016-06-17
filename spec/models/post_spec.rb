require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "requires a title" do
      c = Post.new
      result = c.valid?
      expect(c.errors).to have_key(:title)
    end

    it "requires 7 or more characters" do
      c = Post.new title: "Geo"
      c.valid?
      expect(c.errors).to have_key(:title)
    end

    it "requires a body" do
      c = Post.new
      c.valid?
      expect(c.errors).to have_key(:body)
    end


  end
end
