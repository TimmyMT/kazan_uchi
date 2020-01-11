FactoryBot.define do
  factory :repository do
    url { "https://github.com/rails/rails" }

    trait :invalid_repository do
      url { "https://github.com/rails" }
    end

    trait :not_exist_repo do
      url { "https://github.com/fake_user_TimmyMT/fake_repo_TimmyMT" }
    end
  end
end
