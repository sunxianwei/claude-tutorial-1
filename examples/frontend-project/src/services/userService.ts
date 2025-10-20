/**
 * 用户服务 - API 调用
 */

import axios from 'axios'
import type {
  User,
  UserCreateDto,
  UserUpdateDto,
  UserListQuery,
  UserListResponse
} from '@/types/user'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'

class UserService {
  /**
   * 获取用户列表
   */
  async getUsers(query: UserListQuery): Promise<UserListResponse> {
    const response = await axios.get<UserListResponse>(`${API_BASE_URL}/users`, {
      params: query
    })
    return response.data
  }

  /**
   * 获取单个用户
   */
  async getUserById(id: number): Promise<User> {
    const response = await axios.get<User>(`${API_BASE_URL}/users/${id}`)
    return response.data
  }

  /**
   * 创建用户
   */
  async createUser(data: UserCreateDto): Promise<User> {
    const response = await axios.post<User>(`${API_BASE_URL}/users`, data)
    return response.data
  }

  /**
   * 更新用户
   */
  async updateUser(id: number, data: UserUpdateDto): Promise<User> {
    const response = await axios.put<User>(`${API_BASE_URL}/users/${id}`, data)
    return response.data
  }

  /**
   * 删除用户
   */
  async deleteUser(id: number): Promise<void> {
    await axios.delete(`${API_BASE_URL}/users/${id}`)
  }
}

export const userService = new UserService()
