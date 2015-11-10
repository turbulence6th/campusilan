# Preview all emails at http://localhost:3000/rails/mailers/verification
class VerificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/verification/verify
  def verify
    Verification.verify
  end

end
