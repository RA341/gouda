package api

import (
	"connectrpc.com/connect"
	"context"
	"fmt"
	v1 "github.com/RA341/gouda/generated/category/v1"
	models "github.com/RA341/gouda/models"
	"github.com/RA341/gouda/service"
)

type CategoryHandler struct {
	srv *service.CategoryService
}

func (c *CategoryHandler) ListCategories(_ context.Context, _ *connect.Request[v1.ListCategoriesRequest]) (*connect.Response[v1.ListCategoriesResponse], error) {
	category, err := c.srv.ListCategory()
	if err != nil {
		return nil, fmt.Errorf("error retrieving category: %v", err.Error())
	}

	var result []*v1.Category

	for _, cat := range category {
		result = append(result, cat.ToProto())
	}

	res := connect.NewResponse(&v1.ListCategoriesResponse{Categories: result})
	return res, nil
}

func (c *CategoryHandler) AddCategories(_ context.Context, req *connect.Request[v1.AddCategoriesRequest]) (*connect.Response[v1.AddCategoriesResponse], error) {
	err := c.srv.CreateCategory(req.Msg.Category)
	if err != nil {
		return nil, fmt.Errorf("error creating category: %v", err.Error())
	}

	return connect.NewResponse(&v1.AddCategoriesResponse{}), nil
}

func (c *CategoryHandler) DeleteCategories(_ context.Context, req *connect.Request[v1.DelCategoriesRequest]) (*connect.Response[v1.DelCategoriesResponse], error) {
	cat := (&models.Categories{}).FromProto(req.Msg.GetCategory())

	err := c.srv.DeleteCategory(cat)
	if err != nil {
		return nil, fmt.Errorf("error deleting category: %v", err.Error())
	}

	return connect.NewResponse(&v1.DelCategoriesResponse{}), nil
}
