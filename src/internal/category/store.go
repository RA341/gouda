package category

type Store interface {
	Create(category *Categories) error
	DeleteCategory(categoryId uint) error
	ListCategories(results []Categories) error
}
