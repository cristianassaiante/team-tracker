FactoryBot.define do

  factory :user, class: User do
    username {"cucumber"}
    email {"cucumber@yopmail.com"}
    password {"!1Qazxsw2"}
    confirmed_at {Time.now.utc}
  end

  factory :user2, class: User do
    username {"cucumber2"}
    email {"cucumber2@yopmail.com"}
    password {"!1Qazxsw2"}
    confirmed_at {Time.now.utc}
  end

  factory :chal1, class: Chal do
    name {"cucumber_chal"}
    points {"12000"}
  end

  factory :team, class: Team do
    name {"cucumber_test_team"}
  end

  factory :ctf, class: Ctf do
    name {"BTH_CTF{sM3ll_th3_sH3ll}"}
    onsite {true}
    location {"Sweden, Karlskrona"}
  end

end

