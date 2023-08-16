class CnabTransactionsController < ApplicationController

  def index
    @cnab_transactions = CnabTransaction.paginate(page: params[:page], per_page: 20)
  end

  def new
    @cnab_transaction = CnabTransaction.new
  end

  def create
    file_path = cnab_transaction_params[:file].tempfile.path
    parse_cnab_transaction = ParseCnabTransaction.new(file_path)
    if parse_cnab_transaction.execute
      flash[:notice] = "Arquivo importado com sucesso"
      redirect_to action: :index
    else
      flash.now[:alert] = "Erro ao importar arquivo: #{parse_cnab_transaction.errors.join(', ')}"
      render :new
    end
  end  

  private

  def cnab_transaction_params
    params.require(:cnab_transaction).permit(:file)
  end
end
