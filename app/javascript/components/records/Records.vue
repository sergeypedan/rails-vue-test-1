<template>
  <div class="container">
    <div class="row">
      <div class="col-md-8 py-4">
        <h1>Artists</h1>

        <div class="list-reset mt-4">
          <article class="card" v-for="record in records" :key="record.id" :record="record">
            <div class="card-body">
              <h4 class="card-title">{{ record.title }}</h4>
              <p class="mb-0">{{ getArtist(record) }} — {{ record.year }}</p>

              <form action="" @submit.prevent="updateRecord(record)" v-if="record == editedRecord">
                <div class="form-group">
                  <label>Title</label>
                  <input class="form-control" v-model="record.title">
                </div>

                <div class="form-group">
                  <label>Year</label>
                  <input class="form-control" v-model="record.year">
                </div>

                <div class="form-group">
                  <label for="artist_update">Artist</label>
                  <select id="artist_update" class="form-control" required="" v-model="record.artist">
                    <option disabled value="">Select an artist</option>
                    <option :value="artist.id" v-for="artist in artists" :key="artist.id" :selected="artist.id == 1">{{artist.name}}</option>
                  </select>
                </div>

                <input type="submit" value="Update" class="btn btn-secondary btn-sm">
              </form>
            </div>
            <div class="card-footer">
              <button class="btn btn-link btn-sm" @click.prevent="editRecord(record)"  >Edit</button>
              <button class="btn btn-link btn-sm" @click.prevent="removeRecord(record)">Delete</button>
            </div>
          </article>
        </div>
      </div>

      <div class="col-md-4 py-4">
        <div class="card">
          <div class="card-body">
            <h2 class="h4">Add a new record</h2>

            <form @submit.prevent="addRecord" style="max-width: 500px">
              <div class="form-group">
                <label for="record_title">Title</label>
                <input  id="record_title" type="text" class="form-control" v-model="newRecord.title">
              </div>

              <div class="form-group">
                <label for="record_year">Year</label>
                <input  id="record_year" type="number" class="form-control" v-model="newRecord.year">
              </div>

              <div class="form-group">
                <label for="artist">Artist</label>
                <select id="artist" class="form-control" v-model="newRecord.artist">
                  <option disabled value="">Select an artist</option>
                  <option :value="artist.id" v-for="artist in artists" :key="artist.id">{{artist.name}}</option>
                </select>
                <small class="form-text">Don't see an artist? <router-link to="/artists" class="link-grey">Create one</router-link></small>
              </div>

              <div class="alert alert-danger" v-if="error">{{ error }}</div>
              <input type="submit" value="Add Record" class="btn btn-success mt-2">
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Records',
  data () {
    return {
      artists: [],
      records: [],
      newRecord: [],
      error: '',
      editedRecord: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured
        .get(this.records_path())
        .then(response => { this.records = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured
        .get('/api/v1/artists')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    record_path (record) { return `/api/v1/records/${record.id}` },
    records_path () { return `/api/v1/records/` },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getArtist (record) {
      const recordArtistValues = this.artists.filter(artist => artist.id === record.artist_id)
      let artist
      recordArtistValues.forEach(function (element) { artist = element.name })
      return artist
    },
    addRecord () {
      const value = this.newRecord
      if (!value) return
      this.$http.secured
        .post(this.records_path(), { record: { title: this.newRecord.title, year: this.newRecord.year, artist_id: this.newRecord.artist } })
        .then(response => {
          this.records.push(response.data)
          this.newRecord = ''
        })
        .catch(error => this.setError(error, 'Cannot create record'))
    },
    removeRecord (record) {
      this.$http.secured
        .delete(this.record_path(record))
        .then(response => { this.records.splice(this.records.indexOf(record), 1) })
        .catch(error => this.setError(error, 'Cannot delete record'))
    },
    editRecord (record) {
      this.editedRecord = record
    },
    updateRecord (record) {
      this.editedRecord = ''
      this.$http.secured
        .patch(this.record_path(record), { record: { title: record.title, year: record.year, artist_id: record.artist } })
        .catch(error => this.setError(error, 'Cannot update record'))
    }
  }
}
</script>
