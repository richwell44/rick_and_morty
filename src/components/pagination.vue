<template>
  <div class="pagination">
    <button @click="prevPage" :disabled="currentPage === 1">Previous</button>
    <span>Page {{ currentPage }}</span>
    <button @click="nextPage" :disabled="currentPage === totalPages">
      Next
    </button>
  </div>
</template>

<script>
export default {
  name: "Pagination",
  props: {
    currentPage: Number,
    totalPages: Number,
  },
  emits: ["changePage"],
  methods: {
    prevPage() {
      if (this.currentPage > 1) {
        this.$emit("changePage", this.currentPage - 1);
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.$emit("changePage", this.currentPage + 1);
      }
    },
  },
};
</script>

<style>
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
}
.pagination button {
  margin: 0 10px;
}
</style>
