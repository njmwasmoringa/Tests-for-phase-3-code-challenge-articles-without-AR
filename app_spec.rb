require "spec_helper"
require_relative '../config/environment.rb'

describe 'Test for' do
    before(:all) do         
        @author1 = Author.new("Julius")
        @author2 = Author.new("Mary")
        @author3 = Author.new("CS Student")

        @magazine1 =  Magazine.new("Python", "Coding")
        @magazine2 =  Magazine.new("Ruby", "Coding")
        @magazine3 =  Magazine.new("Investing", "Finance")
        @magazine4 =  Magazine.new("Genesis", "Bible")

        @article1 = Article.new(@author3, @magazine1, "Introduction to python")
        @article2 = Article.new(@author3, @magazine2, "Introduction to Ruby")
        @article3 = Article.new(@author3, @magazine2, "Active Records")
        @article3 = Article.new(@author3, @magazine2, "Rails")
        @article4 = Article.new(@author2, @magazine1, "Django ORM")
        @article5 = Article.new(@author2, @magazine3, "Investment Banking")
        @article6 = Article.new(@author2, @magazine3, "Money market")
        @article7 = Article.new(@author1, @magazine4, "The creation story")
        @article8 = Article.new(@author1, @magazine4, "The Fall")
     end

    describe 'Author' do
        it 'attribute name can be accessed and the value cannot be changed' do
            expect(@author1).to have_attributes(name: "Julius")
            expect(@author1).not_to respond_to(:name=)
            expect(@author1.name).to eq("Julius")
        end
    end

    describe 'Magazine' do
        it 'attributes name and category can be accessed' do
            expect(@magazine1).to have_attributes(name: "Python")
            expect(@magazine1).to respond_to(:name=)
            expect(@magazine1).to have_attributes(category: "Coding")
            expect(@magazine1).to respond_to(:category=)
            expect(@magazine1.name).to eq("Python")
            expect(@magazine1.category).to eq("Coding")
            expect(Magazine).to respond_to(:all)            
        end
    end

    describe 'Article' do
        
        it 'attributes, author, magazine and title can be accessed' do
            expect(@article1).to have_attributes(author: @author3)
            expect(@article1).not_to respond_to(:author=)
            expect(@article1).to have_attributes(magazine: @magazine1)
            expect(@article1).not_to respond_to(:magazine=)
            expect(@article1).to have_attributes(title: "Introduction to python")
            expect(@article1).not_to respond_to(:title=)
            expect(Article).to respond_to(:all)
        end
    end

    describe 'Article' do
        it 'can return author and margazine for that article' do
            expect(@article1.author).to eq(@author3)
            expect(@article1.magazine).to eq(@magazine1)
        end
    end

    describe 'Author' do
        it 'can return all artcle published' do
            expect(@author3).to respond_to(:articles)
            expect(@author3.articles.length).to eq(4)
            expect(@author3).to respond_to(:magazines)
            expect(@author3.magazines.length).to eq(2)
        end
    end

    describe 'Magazine' do
        it 'can return contributors' do
            expect(@magazine1).to respond_to(:contributors)
            expect(@magazine1.contributors.length).to eq(2)
        end
    end

    describe 'Author' do
        it 'can add article' do
            expect(@author2).to respond_to(:add_article)
        end
    end

    describe 'Author' do
        it "can actually add an article" do
            @author2.add_article(@magazine2, "The Ark");
            expect(@author2.articles.length).to eq(4)
        end
    end

    describe 'Author' do
        it 'can return the categories of margazines contributed to' do
            expect(@author2).to respond_to(:topic_areas)
            expect(@author2.topic_areas).to eq(["Coding", "Finance"])
        end
    end

    describe 'Magazine' do
        it 'can be found by name' do
            expect(Magazine).to respond_to(:find_by_name)
        end
    end

    describe 'Magazine' do
        it 'can be found by name' do
            expect(Magazine.find_by_name("Investing")).to eq(@magazine3)
        end
    end

    describe 'Magazine' do
        it 'hass an attribute method article_titles' do
            expect(@magazine3).to respond_to(:article_titles)
        end
    end

    describe 'Magazine' do
        it 'can be found by name' do
            expect(@magazine3.article_titles).to eq(["Investment Banking", "Money market"])
        end
    end

    describe 'Magazine' do
        it 'has an attribute method contributing_authors' do
            expect(@magazine3).to respond_to(:contributing_authors)
        end
    end

    describe 'Magazine' do
        it 'has an attribute method contributing_authors' do
            expect(@magazine2.contributing_authors).to eq([@author3])
        end
    end

end

