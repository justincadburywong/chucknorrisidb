require 'spec_helper'

describe Joke do
  let(:joke1) { Joke.new }
  let(:joke2) { Joke.new(joke: "bunch of stuff", categories: ["nerdy"]) }

  context "Validations" do
    it "should not validate a saved joke" do
      joke1.valid?
    end
    it "should validate a saved joke" do
      joke2.valid?
    end
  end

  context "#Not Created" do
    it "does not have an id" do
      expect(joke1.id).to eq nil
    end
  	it "does not have a joke" do
  		expect(joke1.joke).to eq nil
  	end
 		it "does not have a category" do
      expect(joke1.categories.empty?).to eq true
    end
		it "should not increase total entries in database when saved" do
			expect {
				joke1.save
			}.not_to change(Joke, :count)
		end
  end

  context "#Created" do
    it "has a joke" do
      expect(joke2.joke).to eq("bunch of stuff")
    end
    it "has a category entry" do
      expect(joke2.categories.first).to eq("nerdy")
    end
		it "should increase total entries in database when saved" do
			expect {
				joke2.save
			}.to change(Joke, :count).by(1)
		end
  end

  context "#Updated" do
    it "has an updated joke" do
			joke2.update(joke: "Partee")
      expect(joke2.joke).to eq("Partee")
    end
    it "has an updated category" do
			joke2.update(categories: ["Partee time!"])
      expect(joke2.categories.first).to eq("Partee time!")
    end
  end

	context "#Destroyed" do
		it "should reduce the total entries in the database" do
      joke2.save
      expect {
        joke2.destroy
      }.to change(Joke, :count).by(-1)
    end
    it "should remove joke from the database" do
      joke2.save
      joke2.destroy
      expect(Joke.last).to eq(nil)
    end
	end
end
