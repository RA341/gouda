package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/category/v1"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
	"gorm.io/gorm"
)

type CategoryServer struct {
	api *Env
}

func (catSrv *CategoryServer) ListCategories(_ context.Context, _ *connect.Request[v1.ListCategoriesRequest]) (*connect.Response[v1.ListCategoriesResponse], error) {
	category, err := service.ListCategory(catSrv.api.Database)
	if err != nil {
		return nil, fmt.Errorf("error retrieving category: %v", err.Error())
	}

	var result []*v1.Category

	for _, cat := range category {
		result = append(result, &v1.Category{
			ID:       uint64(cat.ID),
			Category: cat.Category,
		})
	}

	res := connect.NewResponse(&v1.ListCategoriesResponse{Categories: result})
	return res, nil
}
func (catSrv *CategoryServer) AddCategories(_ context.Context, req *connect.Request[v1.AddCategoriesRequest]) (*connect.Response[v1.AddCategoriesResponse], error) {
	err := service.CreateCategory(catSrv.api.Database, req.Msg.Category)
	if err != nil {
		return nil, fmt.Errorf("error creating category: %v", err.Error())
	}

	return nil, nil
}
func (catSrv *CategoryServer) DeleteCategories(_ context.Context, req *connect.Request[v1.DelCategoriesRequest]) (*connect.Response[v1.DelCategoriesResponse], error) {
	err := service.DeleteCategory(catSrv.api.Database, &models.Categories{
		Model:    gorm.Model{ID: uint(req.Msg.GetCategory().ID)},
		Category: req.Msg.GetCategory().Category,
	})
	if err != nil {
		return nil, fmt.Errorf("error deleting category: %v", err.Error())
	}

	return nil, nil
}
