<template lang='pug'>
  b-form(@submit="onSubmit")
    b-form-input(
      id="input-name",
      v-model="form.name",
      type="text",
      placeholder="Lastname, Name"
    )
    br
    markdown-editor(
      :value='description',
      v-on:valueChange='setDescription'
    )
    br
    b-form-group(
      id="input-group-1",
      label="Avatar:",
      label-for="input-1"
    )
      b-form-file(
        placeholder="Choose a file...",
        @input="changeFile",
        drop-placeholder="Drop file here..."
      )
    b-form-group(
      id="input-group-telephone",
      label="Telephone:",
      label-for="input-telephone"
    )
      b-form-input(
        id="input-telephone",
        v-model="form.telephone",
        type="text"
      )
    b-form-group(
      id="input-group-mobile",
      label="Mobile:",
      label-for="input-mobile"
    )
      b-form-input(
        id="input-mobile",
        v-model="form.mobile",
        type="text"
      )
    b-form-group(
      id="input-group-fax",
      label="Fax:",
      label-for="input-fax"
    )
      b-form-input(
        id="input-fax",
        v-model="form.fax",
        type="text"
      )
    hr.divider
    .row
      .col-4
        b-form-group(
          id="input-group-street",
          label="Street:",
          label-for="input-street"
        )
          b-form-input(
            id="input-street",
            v-model="form.street",
            type="text"
          )
      .col-4
        b-form-group(
          id="input-group-number",
          label="Number:",
          label-for="input-number"
        )
          b-form-input(
            id="input-number",
            v-model="form.number",
            type="text"
          )
      .col-4
        b-form-group(
          id="input-group-zip",
          label="Zip:",
          label-for="input-zip"
        )
          b-form-input(
            id="input-zip",
            v-model="form.zip",
            type="text"
          )
    .row
      .col-4
        b-form-group(
          id="input-group-city",
          label="City:",
          label-for="input-city"
        )
          b-form-input(
            id="input-city",
            v-model="form.city",
            type="text"
          )
      .col-4
        b-form-group(
          id="input-group-country",
          label="Country:",
          label-for="input-country"
        )
          b-form-input(
            id="input-country",
            v-model="form.country",
            type="text"
          )
    b-button(type="submit", variant="success") Create contact
    a.btn.btn-secondary.pull-right(href='/administration/contacts') Cancel
    br
    br
</template>

<script>
import MarkdownEditor from '../markdown_editor'

export default {
  components: {
    MarkdownEditor
  },
  props: [
    'name',
    'description',
    'telephone',
    'mobile',
    'fax',
    'street',
    'number',
    'zip',
    'city',
    'country'
  ],
  data () {
    return {
      form: {
        name: null,
        description: null,
        telephone: null,
        mobile: null,
        fax: null,
        Street: null,
        number: null,
        zip: null,
        city: null,
        country: null
      },
      contactAvatar: null
    } 
  },
  mounted () {
    this.form.name = this.name
    this.form.description = this.description
    this.form.telephone = this.telephone
    this.form.mobile = this.mobile
    this.form.fax = this.fax
    this.form.street = this.street
    this.form.number = this.number
    this.form.zip = this.zip
    this.form.city = this.city
    this.form.country = this.country
  },
  methods: {
    onSubmit () {
      this.$emit('onSubmit', {
        attributes: {
          name: this.form.name,
          description: this.form.description,
          telephone: this.form.telephone,
          mobile: this.form.mobile,
          'address-fax': this.form.fax,
          'address-street': this.form.street,
          'address-number': this.form.number,
          'address-zip': this.form.zip,
          'address-city': this.form.city,
          'address-country': this.form.country,
        },
        relationships: {
          'contact-avatar': {
            data: {
              type: 'contact-avatars',
              id: this.contactAvatar.id
            }
          }
        }
      })
    },
    setDescription (value) {
      this.form.description = value
    },
    changeFile (file) {
      let formData = new FormData();
      let headers = { 'Content-Type': 'multipart/form-data' }
      formData.append('data[file]', file)
      let that = this

      this.$store.getters.axios.post( '/api/v1/contact_avatars', formData, { headers })
      .then(function(response) {
        that.contactAvatar = response.data.data
      })
    }
  }
}
</script>
