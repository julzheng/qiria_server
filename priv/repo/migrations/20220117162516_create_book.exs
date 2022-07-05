defmodule Infrastructure.Persistence.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add(:title, :string)
      add(:authors, :string)
      add(:ISBN, :string)
      add(:year, :string)
      add(:language, :string)
      add(:edition, :string)

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:chapter_groups) do
      add(:title, :string)
      add(:book_id, references(:books))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:chapters) do
      add(:title, :string)
      add(:chapter_group_id, references(:chapter_groups))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:problem_groups) do
      add(:title, :string)
      add(:page_number, :string)
      add(:chapter_group_id, references(:chapters))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:problems) do
      add(:title, :string)
      add(:problem_group_id, references(:problem_groups))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:solutions) do
      add(:solution_content, :text)
      add(:problem_id, references(:problems))
      add(:author_id, references(:users))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end

    create table(:comments) do
      add(:comment_content, :text)
      add(:solution_id, references(:solutions))
      add(:author_id, references(:users))
      add(:parent_id, references(:comments))

      add(:deleted_at, :utc_datetime_usec)
      timestamps(type: :utc_datetime_usec)
    end
  end
end
