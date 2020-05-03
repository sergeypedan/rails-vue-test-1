<template>
  <div class="container">
    <div class="row">
      <div class="col-md-8 py-4">
        <article class="card mt-4" v-for="artist in artists" :key="artist.id" :artist="artist">
          <div class="card-body">
            <h4 class="card-title">{{ artist.name }}</h4>
          </div>

          <div v-if="artist == editedArtist">
            <form action="" @submit.prevent="updateArtist(artist)">
              <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
                <input class="input" v-model="artist.name" />
                <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
              </div>
            </form>
          </div>
          <div class="card-footer">
            <button class="btn btn-link" @click.prevent="editArtist(artist)">Edit</button>
            <button class="btn btn-link" @click.prevent="removeArtist(artist)">Delete</button>
          </div>
        </article>
      </div>

      <div class="col-md-4 py-4">
        <h2 class="h3">Add a new artist</h2>
        <form action="/" @submit.prevent="addArtist">
          <div class="form-group">
            <label for="new-artist"></label>
            <input  id="new-artist" class="form-control" required="" v-model="newArtist.name" />
          </div>
          <div class="alert alert-danger" v-if="error">{{ error }}</div>
          <input type="submit" value="Submit" class="btn btn-primary" />
        </form>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: 'Artists',
  data () {
    return {
      artists: [],
      newArtist: [],
      error: '',
      editedArtist: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured
        .get('/api/v1/artists')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    artist_path (artist) {
      return `/api/v1/artists/${artist.id}`
    },
    addArtist () {
      const value = this.newArtist
      if (!value) return
      this.$http.secured
        .post('/api/v1/artists/', { artist: { name: this.newArtist.name } })
        .then(response => {
          this.artists.push(response.data)
          this.newArtist = ''
        })
        .catch(error => this.setError(error, 'Cannot create artist'))
    },
    removeArtist (artist) {
      this.$http.secured
        .delete(this.artist_path(artist))
        .then(response => { this.artists.splice(this.artists.indexOf(artist), 1) })
        .catch(error => this.setError(error, 'Cannot delete artist'))
    },
    editArtist (artist) {
      this.editedArtist = artist
    },
    updateArtist (artist) {
      this.editedArtist = ''
      this.$http.secured
        .patch(this.artist_path(artist), { artist: { name: artist.name } })
        .catch(error => this.setError(error, 'Cannot update artist'))
    }
  }
}
</script>
