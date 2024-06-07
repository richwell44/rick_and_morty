<template>
  <div id="app">
    <h1>Rick and Morty Characters</h1>
    <div class="filters">
      <input v-model="name" placeholder="Filter by name" />
      <select v-model="status">
        <option value="">All Statuses</option>
        <option value="alive">Alive</option>
        <option value="dead">Dead</option>
        <option value="unknown">Unknown</option>
      </select>
      <button @click="applyFilters">Apply</button>
    </div>
    <div class="character-list">
      <CharacterCard
        v-for="character in characters"
        :key="character.id"
        :character="character"
      />
    </div>
    <Pagination
      :currentPage="currentPage"
      :totalPages="totalPages"
      @changePage="changePage"
    />
  </div>
</template>

<script>
import { ref, onMounted, watch } from "vue";
import CharacterCard from "./components/CharacterCard.vue";
import Pagination from "./components/Pagination.vue";

export default {
  name: "App",
  components: {
    CharacterCard,
    Pagination,
  },
  setup() {
    const characters = ref([]);
    const currentPage = ref(1);
    const totalPages = ref(0);
    const name = ref("");
    const status = ref("");

    const fetchCharacters = async () => {
      const response = await fetch(
        `https://rickandmortyapi.com/api/character?page=${currentPage.value}&name=${name.value}&status=${status.value}`
      );
      const data = await response.json();
      characters.value = data.results;
      totalPages.value = data.info.pages;
    };

    const applyFilters = () => {
      currentPage.value = 1;
      fetchCharacters();
    };

    const changePage = (page) => {
      currentPage.value = page;
      fetchCharacters();
    };

    onMounted(fetchCharacters);

    watch([name, status], applyFilters);

    return {
      characters,
      currentPage,
      totalPages,
      name,
      status,
      applyFilters,
      changePage,
    };
  },
};
</script>

<style>
#app {
  text-align: center;
}
.filters {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px 0;
}
.filters input,
.filters select {
  margin: 0 10px;
}
.character-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
</style>
