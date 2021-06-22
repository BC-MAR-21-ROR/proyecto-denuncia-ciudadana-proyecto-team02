require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  describe '#denounce_created' do
    let(:mail) do
      ApplicationMailer.with(
        user: FactoryBot.create(:user, email: 'test@gmail.com'),
        denounce: FactoryBot.create(:denounce)
      ).denounce_created
    end

    it 'renders the headers' do
      expect(mail.subject).to match(/denounce has been created/)
      expect(mail.to).to eq(['test@gmail.com'])
      expect(mail.from).to eq(['denunciaciudadana.team02@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(/A new denounce/)
    end
  end
end
