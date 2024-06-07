<template>
  <div>
    <h1>Rick and Morty Characters</h1>
    <div>
      <input v-model="filters.name" placeholder="Name" />
      <select v-model="filters.status">
        <option value="">All</option>
        <option value="alive">Alive</option>
        <option value="dead">Dead</option>
        <option value="unknown">Unknown</option>
      </select>
      <button @click="applyFilters">Apply</button>
    </div>
    <div v-if="loading">Loading...</div>
    <div v-else class="character-list">
      <div v-for="character in characters" :key="character.id" class="character-card">
        <img :src="character.image" alt="Character Image" />
        <h2>{{ character.name }}</h2>
        <p>Status: {{ character.status }}</p>
        <p>Species: {{ character.species }}</p>
        <p>Gender: {{ character.gender }}</p>
        <p>Origin: {{ character.origin.name }}</p>
      </div>
    </div>
    <CharacterPagination 
      :info="info"
      @prev-page="prevPage"
      @next-page="nextPage"
    />
  </div>
</template>

<script>
import axios from 'axios';
import CharacterPagination from './CharacterPagination.vue';

export default {
  data() {
    return {
      characters: [],
      info: {},
      page: 1,
      loading: false,
      filters: {
        name: '',
        status: ''
      }
    };
  },
  components: {
    CharacterPagination
  },
  created() {
    this.fetchCharacters();
  },
  methods: {
    async fetchCharacters() {
      this.loading = true;
      try {
        const response = await axios.get(`https://rickandmortyapi.com/api/character`, {
          params: {
            page: this.page,
            name: this.filters.name,
            status: this.filters.status
          }
        });
        this.characters = response.data.results;
        this.info = response.data.info;
      } catch (error) {
        console.error(error);
      } finally {
        this.loading = false;
      }
    },
    applyFilters() {
      this.page = 1;
      this.fetchCharacters();
    },
    nextPage() {
      if (this.info.next) {
        this.page++;
        this.fetchCharacters();
      }
    },
    prevPage() {
      if (this.page > 1) {
        this.page--;
        this.fetchCharacters();
      }
    }
  }
};
</script>

<style>
.character-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.character-card {
  border: 1px solid #ccc;
  padding: 10px;
  width: 200px;
  text-align: center;
}

.character-card img {
  width: 100%;
  height: auto;
}

.pagination {
  margin-top: 20px;
}
</style>
