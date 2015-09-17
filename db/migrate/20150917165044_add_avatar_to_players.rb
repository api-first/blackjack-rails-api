class AddAvatarToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :avatar, :string, null: false, default: "
iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAMAAACdt4HsAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAG9QTFRF7+/v7u7uzc3N0NDQzs7O7Ozs0dHR6Ojoz8/P4eHh2NjY29vb1dXV7e3t09PT6enp3Nzc4ODg1NTU5OTk5eXl6urq5+fn1tbW19fX0tLS6+vr39/f4+Pj4uLi3t7e2dnZ5ubm2tra3d3dzMzM8PDwN0UjmgAAAfdJREFUeNrs1smSozAMAFB5A8y+hzUkMf//jR3S01NdBNsyuU2N7n42WJYE64cB/4F/G4CsiNUW/HEKELciDF6AurSNSIgjMFyZ+htsGedKuADkdv+1/vkVzEvDOUEDbRRz9RZ93uAA8Dt1HAVBAUlIj9fTqMEAQx5oDkAvLQaYNPtvf6FGACLSrldcghUA6ekBFddgAaC5GNYrGhIb4McmQPXE+gkjMwGpFVi1WfSK0g4kuWE9z8F+jSagrOxAczcAXWsHbqZ7vCCAKTVdwmQH5t4AeMWHJ+glfJYHYQYfvUZaIJ6zKZHYhADIw/APKwQAo+EWMRVprQJ9NfBRRTXSCUyiyjpkmorAF2xjKammJgMS0BSlmGB745DzwzTGd+fs6EnnAg/A/H6EoHaZD8Rbe6HR4DShkG7fVzNwG3F2lZFdXYesaF+KXIesZQ84niArd3ewDHgAnj063N9jcEWPeSQTdXiQBxILZGN0+JrSsSF2gIj2qpsQ+F1WfkLABIj6EQfaIes5r3ZF7QsNAH4ll5RR44TCvTSOZNWKNyAZZFh6ChPcK7vR/xnf4c/uRY5b/ZPa99knv4AqDgLqAlCeXr+FDUiqWLlHH7XkGyBTqc4EeyXnM2+NM4ky9uoXkEh2EgiibANunTobNNyAuTwNKG9dvwQYAFj3GiTfQntsAAAAAElFTkSuQmCC"
  end
end