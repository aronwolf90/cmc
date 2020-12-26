<template lang='pug'>
  .users-index
     index-top-section(
       resource="users",
       :item-text-function="itemTextFunction",
     )
       template(v-slot:btn-new="")
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
                 a.btn.btn-success.float-right(
                   v-if="showContinueBtn",
                   href="/administration/users/new"
                 ) Continue
         template(v-else="")
           a.btn.btn-success(href="/administration/users/new") New user

     br
     br
     b-list-group(flush="")
       b-list-group-item.list-lines(v-for="user in users")
         b-link.text-dark(:href="`/administration/users/${user.id}`")
          | {{ user.attributes.firstname }} {{ user.attributes.lastname }}
         b-badge.pull-right(
           variant="warning",
           v-if="!user.attributes.active"
         ) Disabled
</template>

<script>
import IndexTopSection from 'components/index-top-section'
import IndexListItem from 'components/index-list-item'
import { Utils } from 'vuex-jsonapi-client'

export default {
  components: {
    IndexTopSection,
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
    premium () {
      return Utils.attribute(this.context, 'premium')
    },
    showModal () {
      return !this.premium && this.userCount > 5
    },
    showContinueBtn () {
      return this.userCount < 10
    }
  },
  methods: {
    itemTextFunction (user) {
      return `${user.attributes.firstname} ${user.attributes.lastname}`
    }
  }
}
</script>
