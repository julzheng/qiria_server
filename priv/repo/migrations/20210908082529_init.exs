defmodule Infrastructure.Persistence.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:fullname, :string)
      add(:avatar, :string)

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:auths) do
      add(:email, :string)
      add(:password_hash, :string)
      add(:user_id, references(:users))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create(index("auths", [:email], unique: true))
    create(index("auths", [:email, :deleted_at], unique: true))

    create table(:plans) do
      add(:name, :string)
      add(:price_per_month, :integer)

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:subscriptions) do
      add(:subscription_start, :utc_datetime)
      add(:subscription_end, :utc_datetime)
      add(:user_id, references(:users))
      add(:plan_id, references(:plans))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end
  end
end
