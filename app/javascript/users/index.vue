<template lang='pug'>
  .users-index
    .d-flex.flex-row
      .w-100.mr-2
        index-search-section(
          resource="users",
          :itemTextFunction="itemTextFunction"
        )
      template(v-if="showModal")
        b-button(variant='success', v-b-modal.modal-1='') New user
        b-modal(id="modal-1", :title="`You have created ${userCount} from 10 free users`", v-model="show")
          p To create more than more than 10 users, add your <a href="/administration/admin/payments">payment information</a>
          template(v-slot:modal-footer="")
            .w-100
              b-button(
                variant="primary",
                class="float-left",
                @click="show=false"
              ) Close
              a.btn.btn-success.float-right(href="/administration/users/new") Continue
      template(v-else="")
        a.btn.btn-success(href="/administration/users/new") New user

    br
    br
    
    ul.list-group.list-lines
      index-list-item(
        v-for="user in users",
        resource="users",
        :entry-type="user.type",
        :entry-id="user.id",
        :text="itemTextFunction(user)"
      )
</template>

<script>
import IndexSearchSection from '../components/index-search-section' 
import IndexListItem from '../components/index-list-item'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    IndexSearchSection,
    IndexListItem
  },
  data () {
    return {
      show: false
    }
  },
  asyncComputed: {
    usersResult () {
      return this.$store.dispatch('users')
    },
    contextResult () {
      return this.$store.dispatch('getContext')
    }
  },
  computed: {
    users () {
      if (!this.usersResult) return []
      return this.usersResult.data
    },
    context () {
      if (!this.contextResult) return
      return this.contextResult.data
    },
    userCount () {
      return Utils.attribute(this.context, 'user-count')
    },
    showModal () {
      return !Utils.attribute(this.context, 'premium') &&
        this.userCount > 5
    }
  },
  methods: {
    itemTextFunction(user) {
      return `${user.attributes.firstname} ${user.attributes.lastname}`
    }
  }
}
</script>
