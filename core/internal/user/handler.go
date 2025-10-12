package user

import (
	"context"
	"fmt"

	"connectrpc.com/connect"
	v1 "github.com/RA341/gouda/generated/user/v1"
	"github.com/RA341/gouda/internal/auth"
)

type Handler struct {
	srv *Service
}

func NewHandler(srv *Service) *Handler {
	return &Handler{srv: srv}
}

func (h Handler) UserList(_ context.Context, _ *connect.Request[v1.ListUsersRequest]) (*connect.Response[v1.ListUsersResponse], error) {
	list, err := h.srv.UserList()
	if err != nil {
		return nil, err
	}

	var rpcUserList []*v1.User
	for _, l := range list {
		rpcUserList = append(rpcUserList, auth.UserToRpc(&l))
	}

	return connect.NewResponse(&v1.ListUsersResponse{Users: rpcUserList}), nil
}

func (h Handler) UserAdd(ctx context.Context, req *connect.Request[v1.AddUserRequest]) (*connect.Response[v1.AddUserResponse], error) {
	user := req.Msg.User

	adminSession, err := auth.GetUserSessionFromCtx(ctx)
	if err != nil {
		return nil, err
	}

	role, err := FromRpcRole(user.Role)
	if err != nil {
		return nil, err
	}

	err = h.srv.UserAdd()(
		user.Username,
		user.Password,
		role,
		&adminSession.User,
	)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.AddUserResponse{}), nil
}

func FromRpcRole(role v1.Role) (auth.Role, error) {
	switch role {
	case v1.Role_Admin:
		return auth.RoleAdmin, nil
	case v1.Role_Mouse:
		return auth.RoleMouse, nil
	default:
		return auth.RoleMouse, fmt.Errorf("invalid role")
	}
}

func (h Handler) UserDelete(ctx context.Context, req *connect.Request[v1.UserDeleteRequest]) (*connect.Response[v1.UserDeleteResponse], error) {
	adminSession, err := auth.GetUserSessionFromCtx(ctx)
	if err != nil {
		return nil, err
	}

	deletingUser := uint(req.Msg.UserId)
	if adminSession.UserID == deletingUser {
		return nil, fmt.Errorf("cannot delete yourself dummy")
	}

	err = h.srv.UserDelete(deletingUser)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UserDeleteResponse{}), nil
}

func (h Handler) UserEdit(ctx context.Context, req *connect.Request[v1.UserEditRequest]) (*connect.Response[v1.UserEditResponse], error) {
	rpcUser := req.Msg.EditUser

	var user auth.User

	role, err := FromRpcRole(rpcUser.Role)
	if err != nil {
		return nil, err
	}
	user.Role = role
	user.Username = rpcUser.Username
	user.ID = uint(rpcUser.UserId)

	err = h.srv.UserEdit(&user, rpcUser.Password)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.UserEditResponse{}), nil
}
