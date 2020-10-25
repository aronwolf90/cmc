<template lang='pug'>
  b-form(@submit="onSubmit")
    .row
      .col-md-5
        form-input-avatar(
          id="input-group-1",
          api-url="/api/v1/contact_avatars",
          @change="changeFile",
          :avatar-url="avatarUrl"
        )
      .col-md-7
        b-form-group(
          id="input-name",
          label="Name:",
          label-for="input-telephone"
        )
          b-form-input(
            id="input-name",
            v-model="form.name",
            type="text",
            placeholder="Lastname, Name"
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
    br
    markdown-editor(
      :value='description',
      v-on:valueChange='setDescription'
    )
    br
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
import FormInputAvatar from 'components/form-inputs/avatar'

export default {
  components: {
    MarkdownEditor,
    FormInputAvatar
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
    'country',
    'avatar-url'
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
    onSubmit (event) {
      event.preventDefault()

      let payload = {
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
          'address-country': this.form.country
        }
      }
      if (this.contactAvatar) {
        payload.attributes['contact-avatar-id'] = this.contactAvatar.id
      }
      this.$emit('onSubmit', payload)
    },
    setDescription (value) {
      this.form.description = value
    },
    changeFile (response) {
      this.contactAvatar = response
    }
  }
}
</script>
