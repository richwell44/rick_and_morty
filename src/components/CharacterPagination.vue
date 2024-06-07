<template>
  <div class="pagination">
    <button @click="$emit('prev-page')" :disabled="!info.prev">Previous</button>
    <button @click="$emit('next-page')" :disabled="!info.next">Next</button>
  </div>
</template>

<script>
export default {
  props: {
    info: {
      type: Object,
      required: true
    }
  }
};
</script>

<style>
.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
</style>
