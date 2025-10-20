/**
 * 用户类型定义
 */

export interface User {
  id: number
  username: string
  email: string
  role: 'admin' | 'user' | 'guest'
  avatar?: string
  createdAt: string
  updatedAt: string
}

export interface UserCreateDto {
  username: string
  email: string
  password: string
  role?: 'admin' | 'user' | 'guest'
}

export interface UserUpdateDto {
  username?: string
  email?: string
  role?: 'admin' | 'user' | 'guest'
  avatar?: string
}

export interface UserListQuery {
  page: number
  pageSize: number
  search?: string
  role?: string
}

export interface UserListResponse {
  data: User[]
  total: number
  page: number
  pageSize: number
}
