require "kemal"
require "json"
require "pg"
require "dotenv"

require "./crystal-app/*"

module Crystal::App

    ENV    = Dotenv.load!
    PG_URL = ENV["DATABASE_URL"]
    DB     = PG.connect PG_URL

    get "/" do
        "Hello World of Crystal"
    end

    get "/users" do | env |
        env.response.content_type = "application/json"
        users = DB.exec("SELECT * FROM users")
        users.to_hash.map do | user |
            {
                id: user["id"].as(Int32),
                username: user["username"].as(String),
                firstname: user["firstname"].as(String),
                lastname: user["lastname"].as(String),
            }
        end.to_json
    end

    Kemal.config.port = ENV.fetch("PORT", "3000").to_i
    Kemal.run
end
