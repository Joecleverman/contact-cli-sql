class Main
    attr_accessor :name, :phone, :address, :email
  
    def initialize(name, phone, address, email)
      @name = name
      @phone = phone
      @address = address
      @email = email
    end
  
    def to_s
      "\nName: #{@name}\nPhone: #{@phone}\nAddress: #{@address}\nEmail: #{@email}"
    end
  end