class ParseCnabTransaction
  attr_accessor :file, :path, :capture_errors

  def initialize(path)
    @path = path
    @capture_errors = []
  end

  def execute
    prepare_objects
    create_records
  end

  def errors
    @capture_errors
  end


  def prepare_objects
    @file = File.open(@path.to_s)

    @parsed_data =  file.readlines.map do |row|
      {
        type_transaction: type_transaction(row),
        date_transaction: date_transaction(row),
        value: value(row), 
        cpf: cpf(row),
        card_number: card_number(row),
        hour_transaction: hour_transaction(row),
        store_id: store(row),
      }
    end
  end

  def create_records
    CnabTransaction.transaction do
      begin
        CnabTransaction.create!(@parsed_data)
      rescue ActiveRecord::RecordInvalid => e
        @capture_errors << e
        raise ActiveRecord::Rollback
      end
    end
  end

  def type_transaction(row)
    case row[0..0].to_i
    when 1
      "debit"
    when 2
      "billet"
    when 3
      "financing"
    when 4
      "credit"
    when 5
      "loan_receipt"
    when 6
      "sales"
    when 7
      "ted_receipt"
    when 8
      "doc_receipt"
    when 9
      "rent"
    else
      "debit"
    end
  end

  def date_transaction(row)
    row[1..8].to_date
  end

  def value(row)
    row[9..18].to_f / 100
  end

  def cpf(row)
    row[19..29]
  end

  def card_number(row)
    row[30..41]
  end

  def hour_transaction(row)
    Time.at(row[42..47].to_i).strftime("%H:%M")
  end

  def store_owner(row)
    row[48..61]
  end

  def store_name(row)
    row[62..80].strip
  end

  def store(row)
    store = Store.find_by_name(store_name(row).to_s)
    return store.id if store.present?
    return Store.create!(name: store_name(row).to_s, owner_name: store_owner(row).to_s).id
  end
end
