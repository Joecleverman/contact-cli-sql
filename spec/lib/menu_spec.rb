require_relative '../spec_helper'
require_relative '../../lib/contact.rb'
describe 'Contact' do
    it 'is defined within lib/contact.rb' do
      expect(defined?(Contact)).to be_truthy
      expect(Contact).to be_a(Class)
    end
  
     describe '#initialize=' do
        it 'writes the name of the person to an instance variable @name' do
          merline = Merline.new
          merline.name = "Merline"
  
          expect(merline.instance_variable_get(:@name)).to eq("Merline")
      end

      it 'writes the phone_number of the person to an instance variable @phone_number' do
        merline = Phone.new
        merline.phone = "(509)44441112"

        expect(merline.instance_variable_get(:@phone)).to eq("(509)44441112")
      end

      it 'writes the address of the person to an instance variable @address' do
        merline = Merline.new
        merline.address = "Delmas 83"

        expect(merline.instance_variable_get(:@address)).to eq("Delmas 83")
     end

     it 'writes the email of the person to an instance variable @email' do
        merline = Merline.new
        merline.email = "merline@noukod.com"

        expect(merline.instance_variable_get(:@email)).to eq("merline@noukod.com")
     end
    end
     describe ".create_table" do
        it 'creates the contact table in the database' do
          Contact.create_table
          table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contacts';"
          expect(DB[:conn].execute(table_check_sql)[0]).to eq(['contacts'])
        end
      end

      describe ".drop_table" do
        it 'drops the contacts table from the database' do
          Contact.create_table
          Contact.drop_table
          table_check_sql = "SELECT tbl_name FROM sqlite_master WHERE type='table' AND tbl_name='contacts';"
          expect(DB[:conn].execute(table_check_sql)[0]).to eq(nil)
        end
      end

      describe "#save" do
    it 'saves an instance of the Contact class to the database' do
      Contact.create_table
      merline.save
      expect(merline.id).to eq(1)
      expect(DB[:conn].execute("SELECT * FROM contacts")).to eq([[1, "Merline","(509)44441112", "Delmas 83", "merline@noukod.com"]])
    end
  end

  describe ".create" do
    before(:each) do
      Contact.create_table
    end

    it 'takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database' do
      Contact.create(name: "Merline", phone: "(509)44441112", address:"Delmas 83", email:"merline@noukod.com")
      expect(DB[:conn].execute("SELECT * FROM contacts")).to eq([[1, "Merline", "(509)44441112", "delmas 83", "merline@noukod.com"]])
    end

    it 'returns the new object that it instantiated' do
      contact = Contact.create(name: "Merline", phone: "(509)44441112", address:"Delmas 83", email:"merline@noukod.com")
      expect(contact).to be_a(Contact)
      expect(contact.name).to eq("Merline")
      expect(contact.phone).to eq("(509)44441112")
      expect(contact.address).to eq("Delmas 83")
      expect(contact.email).to eq("merline@noukod.com")
    end
  end\

  describe '.all' do
    it 'returns all contact instances from the db' do
      merline.name = "Merline"
      merline.address = "Delmas 83"
      merline.phone = "(509)44441112"
      merline.email = "merline@noukod.com"
      merline.save
      

      all_from_db = Contact.all
      expect(all_from_db.size).to eq(2)
      expect(all_from_db.last).to be_an_instance_of(Contact)
      expect(all_from_db.any? {|contact| contact.name == "Merline"}).to eq(true)
    end
  end
  end
