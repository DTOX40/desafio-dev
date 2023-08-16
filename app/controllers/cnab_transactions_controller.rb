class CnabTransactionsController < ApplicationController

  def index
    @cnab_transactions = CnabTransaction.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.json { render json: @cnab_transactions }
    end
  end

  def new
    @cnab_transaction = CnabTransaction.new
  end

  def create
    file_path = cnab_transaction_params[:file].tempfile.path
    parse_cnab_transaction = ParseCnabTransaction.new(file_path)
    if parse_cnab_transaction.execute
      respond_to do |format|
        format.html { redirect_to action: :index, notice: "Arquivo importado com sucesso" }
        format.json { render json: { message: "Arquivo importado com sucesso" }, status: :created }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = "Erro ao importar arquivo: #{parse_cnab_transaction.errors.join(', ')}"
          render :new
        end
        format.json { render json: { error: "Erro ao importar arquivo: #{parse_cnab_transaction.errors.join(', ')}" }, status: :unprocessable_entity }
      end
    end
  end

  private

  def cnab_transaction_params
    params.require(:cnab_transaction).permit(:file)
  end
end
